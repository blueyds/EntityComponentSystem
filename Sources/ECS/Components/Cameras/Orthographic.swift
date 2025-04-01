import SwiftMatrix
extension Matrix{
    
    static func orthographic(left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) -> Matrix {
        return Matrix(
            [ 2 / (right - left), 0, 0, 0],
            [0, 2 / (top - bottom), 0, 0],
            [0, 0, 1 / (far - near), 0],
            [(left + right) / (left - right), (top + bottom) / (bottom - top), near / (near - far), 1]
        )
        
    }
}
extension Camera{
    public class Orthographic: Camera.CameraProtocol{
        public var entity: (any Entity)!
        public static let typeID: Int = Manager.getNewComponentTypeID()
        private let left: Float
		private let right: Float
		private let bottom: Float
		private let top: Float
		private let near: Float
		private let far: Float
		public init(left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float){
			self.left = left
			self.right = right
			self.bottom = bottom
			self.top = top
			self.near = near
			self.far = far
		}
        public var projectionMatrix: Matrix{
            .orthographic(
                left: left, 
                right: right, 
                bottom: bottom, 
                top: top, 
                near: near, 
                far: far)
        }
    }

}
